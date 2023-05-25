// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract ExampleTheGraph {

    enum Status { 
        NEW, 
        FINISHED
    }

    struct Rating {
        uint8 score;
        string taskId; 
    }

    struct User {     
        string nickname;
        Rating[] ratings;
    }

    struct Task {
        string id;
        Status status;
        string details;
    }

    mapping(address => User) internal users;
    mapping(address => bool) internal joinedUsers;
	mapping(string => Task) internal tasks;
    mapping(string => address) internal resolverByTaskId; 
    mapping(string => address) internal ownerByTaskId; 

    event Joined(address user, string nickname);
    event Created(address owner, string taskId, string details);
    event Finished(address resolver, string taskId, uint8 score);

    /**
	 * @dev Join to smart contract with a nickname.
	 * @param nickname for the address.
	 */
    function join(string calldata nickname) external {
        require(!joinedUsers[msg.sender], "User already exists");
        users[msg.sender].nickname = nickname;
        joinedUsers[msg.sender] = true;
        emit Joined(msg.sender, nickname);
    }

    /**
	 * @dev Create a task with details to realize.
     * @param taskId indicates the id to identify it.
     * @param details indicates details for the task. 
	 */
	function createTask(string memory taskId, string memory details) external {
        require(joinedUsers[msg.sender], "Unregistered user");
        require(tasks[taskId].status == Status.NEW, "Task invalid Status");
        
        tasks[taskId].id = taskId;
        tasks[taskId].status = Status.NEW;
        tasks[taskId].details = details;
        ownerByTaskId[taskId] = msg.sender;

        emit Created(msg.sender, taskId, details);
	}

    /**
	 * @dev Finish a task and to rating owner task.
     * @param taskId indicates the id to finish. 
     * @param score indicates the rating for the owner's task. 
	 */
	function finishTask(string memory taskId, uint8 score) external {
        require(joinedUsers[msg.sender], "Unregistered user");
        require(tasks[taskId].status == Status.NEW, "Task invalid Status");
        
        tasks[taskId].status = Status.FINISHED;
        resolverByTaskId[taskId] = msg.sender; 
        users[ownerByTaskId[taskId]].ratings.push(Rating(score, taskId)); 

        emit Finished(msg.sender, taskId, score);
	}

    /**
	 * @dev Get User for address indicated.
     * @param adr indicates the address to query. 
     * @return User from address.
	 */
    function getUser(address adr) external view returns (User memory) {
        return users[adr];
    }

    /**
	 * @dev Get Task for id indicated.
     * @param taskId indicates the id to query. 
     * @return Task from id.
	 */
    function getTask(string calldata taskId) external view returns (Task memory) {
        return tasks[taskId];
    }

    /**
	 * @dev Get Ratings for user indicated.
     * @param user indicates the address to query. 
     * @return Array of ratings from user.
	 */
    function getRatings(address user) external view returns (Rating[] memory) {
        return users[user].ratings;
    }
}