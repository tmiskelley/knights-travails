# Knights-travails
This project is my implementation of a graph traversal algorithm. I use BFS (Breadth First Search) to calculate the shortest path between two squares on a chess board for the knight piece.

The program works by recursively visiting each node from the start unitl it locates the desired end node. Once the end node is found, the path is reconstructed backwards from the finish square by getting the parent square until the beginning is reached again.

# How to use
Include the main.rb file into the file you're working in, and call the #knight_moves() function; the function takes a start square and an end square, which should be passed a two integer array representing the desired places on the chess board. The board is represented in coordinates: a1 = [0, 0], h8 = [7, 7]

Ex: knight_moves([0, 0], [7, 7])
