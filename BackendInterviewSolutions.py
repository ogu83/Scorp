from typing import Iterable
from collections import Counter
import psycopg2

class DbObject:
    def __init__(self, id: int):
        self.id = id

    def __hash__(self) -> int:
        return self.id    

class User(DbObject):
    def __init__(self, id: int, username: str, full_name: str, profile_picture: str, fallowed: bool):
        super().__init__(id)
        self.username = username
        self.full_name = full_name
        self.profile_picture = profile_picture
        self.fallowed = fallowed

    def __repr__(self) -> str:
        return f"({self.id}, {self.username}, {self.full_name}, {self.fallowed})"

class Post(DbObject):
    def __init__(self, id: int, description: str, owner: User, image: str, created_at: int, liked: bool):
        super().__init__(id)
        self.description = description
        self.owner = owner
        self.image = image
        self.created_at = created_at
        self.liked = liked

    def __repr__(self) -> str:
        return f"({self.id}, {self.description}, {self.owner}, {self.created_at}, {self.liked})"

def get_posts(userid: int, post_ids: Iterable[int]) -> Iterable[Post]:
    conn = psycopg2.connect("dbname=Scorp user=postgres password=postgres")
    cursor = conn.cursor()
    
    # COLLECT ALL POSTS FROM DB
    post_ids_str = ','.join(map(lambda x: str(x),post_ids))
    cursor.execute(f"SELECT * FROM public.post WHERE id IN ({post_ids_str})")
    db_posts = cursor.fetchall()
    
    # COLLECT ALL USERS RELATED TO THE POSTS FROM DB
    user_ids = set(map(lambda x: str(x[2]), db_posts))
    user_ids_str = ','.join(user_ids)
    cursor.execute(f"SELECT * FROM public.user WHERE id IN ({user_ids_str})")
    db_users = cursor.fetchall()

    # COLLECT USER's LIKED POST IDS FROM DB
    cursor.execute(f"SELECT * FROM public.like WHERE user_id = {userid}")
    db_likes = cursor.fetchall()
    user_liked_post_ids = list(map(lambda x: x[2], db_likes))

    # COLLECT USER's FALLOWED USER IDS FROM DB
    cursor.execute(f"SELECT * FROM public.follow WHERE follower_id = {userid}")
    db_follow = cursor.fetchall()
    user_followed_user_ids = list(map(lambda x: x[1], db_follow))

    db_posts = dict(map(lambda x: (x[0], x[1:]), db_posts))
    db_users = dict(map(lambda x: (x[0], x[1:]), db_users))

    posts = []
    for post_id in post_ids:
        if post_id in db_posts.keys():
            db_post = db_posts[post_id]
            
            post_user_id = db_post[1]
            post_user = db_users[post_user_id]
            post_user = User(post_user_id, post_user[0], post_user[1], post_user[2], post_user_id in user_followed_user_ids)
            
            post = Post(post_id, db_post[0], post_user, db_post[2], db_post[3], post_id in user_liked_post_ids)
            posts.append(post)
        else:
            posts.append(None)

    return posts

def merge_posts(list_of_posts: Iterable[Iterable[Post]]) -> Iterable[Post]:
    list_of_posts = Counter(reversed((sum(list_of_posts, [])))) 
    # O(N) iterator, already asc sorted, reversed will get descending sorted, counter will remove duplicates
    def condition(x: Post):
        return -1 * x.created_at, x.id
    list_of_posts = sorted(list_of_posts, key=condition) 
    # the general sorted time complexity of sorted is known O(nlogn) is not applicable here because
    # if there are elements with same created_at O(N*M) worst case, best case O(N), 

    return list_of_posts

# TEST: get_posts over user 2
posts = get_posts(2, [1,2,3,4,5])
print("TEST get_posts")
print(posts)

#TEST: merge_posts
posts = [[posts[0], posts[1]], [posts[1], posts[2]], [posts[3], posts[4]], [posts[4]]]
posts = list(merge_posts(posts))
print("TEST merge_posts")
print(posts)
