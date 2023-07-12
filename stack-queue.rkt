#lang dssl2

let eight_principles = ["Know your rights.",
"Acknowledge your sources.",
"Protect your work.",
"Avoid suspicion.",
"Do your own work.",
"Never falsify a record or permit another person to do so.",
"Never fabricate data, citations, or experimental results.",
"Always tell the truth when discussing your work with your instructor."]

# HW2: Stacks and Queues

import ring_buffer

interface STACK[T]:
    def push(self, element: T) -> NoneC
    def pop(self) -> T
    def empty?(self) -> bool?

# Defined in the `ring_buffer` library; copied here for reference.
# Do not uncomment! or you'll get errors.
#interface QUEUE[T]:
#     def enqueue(self, element: T) -> NoneC
#     def dequeue(self) -> T
#     def empty?(self) -> bool?

# Linked-list node struct (implementation detail):
struct _cons:
    let data
    let next: OrC(_cons?, NoneC)

###
### ListStack
###

class ListStack[T] (STACK):
    let head
    
    
    

    # Any fields you may need can go here.

    # Constructs an empty ListStack.
    def __init__ (self):
        self.head = None
        
        
    def empty?(self):
        return not self.head
        
    def push(self, element: T):
        let node = _cons(element, self.head)
        self.head = node

        
        
        
    def pop(self):
        if not self.head:
            error("stack is empty, can't pop")
        let top_element = self.head.data
        println(top_element)
        self.head = self.head.next
        return top_element
        
        
   
    #   ^ YOUR CODE GOES HERE

    # Other methods you may need can go here.


test "woefully insufficient":
    #let node = _cons("Data", None)
    let s = ListStack()
    #println(s)
    s.push(2)
    s.push(3)
    s.push(4)
    s.push(5)
    #println(s)
    s.pop()
    s.pop()
    s.pop()
    assert s.pop() == 5
    assert s.pop() == 4
    assert s.pop() == 3
    
    
    
test "empty?()":
    let s = ListStack()
    assert s.empty?() == True
    let node = _cons("Data", None)
    let s2 = ListStack()
    s2.push(5) 
    assert s2.empty?() == False
    s2.pop() 
    assert s2.empty?() == True
    

###
### ListQueue
###

    
    
class ListQueue[T] (QUEUE): 
    let head
    let tail

    # Any fields you may need can go here.

    # Constructs an empty ListQueue.
    def __init__ (self):
        self.head = None
        self.tail = None
    
    def empty?(self):
        return not self.head
        
    def enqueue(self, element: T):
        let new_node = _cons(element, None)
        self.head = new_node
        


        

        
        
    def dequeue(self):
        if not self.head:
            error("queue is empty")
        let front_element = self.head.data
        println(front_element)
        let back_element = self.tail
        println(back_element)
        self.head = self.head.next
        if not self.head:
            self.tail = None
        return front_element
        
let h = ListQueue()
h.enqueue(2)
h.enqueue(3)
h.enqueue(4)

 
    
    #   ^ YOUR CODE GOES HERE

    # Other methods you may need can go here.

test "woefully insufficient, part 2":
    let q = ListQueue()
    #println(q)
    q.enqueue(2)
    q.enqueue(3)
    q.enqueue(4)
    #println(q)
    assert q.dequeue() == 2
    assert q.dequeue() == 3
    assert q.dequeue() == 4
    #println(q)

    
test "empty?()":
    let s = ListQueue()
    assert s.empty?() == True
    #let node = _cons("Data", None)
    let s2 = ListQueue()
    s2.enqueue(2) 
    assert s2.empty?() == False    
    
###
### Playlists
###

struct song:
    let title: str?
    let artist: str?
    let album: str?

# Enqueue six songs of your choice to the given queue, then return the first
# song that should play.
def fill_playlist (q: QUEUE!):
    let playlist = [song("Yesterday", "The Beatles", "Help!"), song("Hey There Delilah", "Plain White T's", "All That We Needed"), song("Brazil", "Declan McKenna", "What Do You Think About the Car?"), song("Billie Jean", "Micheal Jackson", "Thriller"), song("ceilings", "Lizzy McAlphine", "Five Seconds Flat"), song("Writer in The Dark", "Lorde", "Melodrama")]
    for song in playlist:
        q.enqueue(song)
    return q.dequeue()
        
#   ^ YOUR CODE GOES HERE



test "ListQueue playlist":
    let q = ListQueue()
    assert fill_playlist(q).title == "Yesterday"
    assert fill_playlist(q).artist == "The Beatles"
    assert fill_playlist(q).album == "Help!"

# To construct a RingBuffer: RingBuffer(capacity)
test "RingBuffer playlist":
    let b = RingBuffer(6)
    #println(fill_playlist(b).title)
    assert fill_playlist(b).title == "Yesterday"
