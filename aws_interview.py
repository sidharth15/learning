#  Given a 2D map of 0's and 1's, where 1's are land and 0's are 
#  water, count the islands.


# 1 0 1 0 
# 1 0 1 0
# 1 1 1 1
# 0 0 1 0

# 1 1 0 
# 1 1 0
# 0 0 5

def dfs(i, j, matrix):
    if i < 0 or j < 0 or i >= len(matrix) or j >= len(matrix[i]):
        return
    
    if matrix[i][j] == "0":
        return
    
    # i've already been here, and don't treat this as 'land' anymore
    matrix[i][j] = "0"
    
    # exploring the right position to the current
    dfs(i, j + 1, matrix)
    
    # exploring the bottom position the the current
    dfs(i + 1, j, matrix)
    
    # exploring the left position to the current
    dfs(i, j - 1, matrix)
    
    # exploring the top position the current
    dfs(i - 1, j, matrix)
    
# m x n x 4 ^ (m*n)

def findCount(matrix):
    numOfIslands = 0
    
    for i in range(len(matrix)):
        
        # iterate till the num of columns in the ith row
        for j in range(len(matrix[i])):
            
            if matrix[i][j] == "1":
                numOfIslands += 1
                
                # this function will explore the current island and mark them as visited
                dfs(i, j, matrix)
                
    
    return numOfIslands
    
    
def findCount():
    