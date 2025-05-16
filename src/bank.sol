// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract bank {
    struct User {
        string name;
        uint256 balance;
    }
    mapping (address => uint256) public balances;
    mapping (address => User) public users;
    mapping (address => bool) public isRegistered;
    address[] public userAddresses;
    address public owner;
    uint256 public totalUsers;
    uint256 public totalBalance;
    uint256 public totalDeposits;
    uint256 public totalWithdrawals;
    uint256 public totalTransfers;
    uint256 public totalTransactions;
    
        // Add at least one function implementation to avoid syntax errors
    function registerUser(string memory _name) public {
        require(!isRegistered[msg.sender], "User already registered");
        require(bytes(_name).length > 0, "Invalid name");
        users[msg.sender].name = _name;
        isRegistered[msg.sender] = true;
        userAddresses.push(msg.sender);
    }

    function deposit() public payable {
        require(isRegistered[msg.sender], "User not registered");
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        totalBalance += msg.value;
        totalDeposits += 1;
        totalTransactions += 1;
    }
    function withdraw(uint256 _amount) public virtual {
        require(isRegistered[msg.sender], "User not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        totalBalance -= _amount;
        totalWithdrawals += 1;
        totalTransactions += 1;
        payable(msg.sender).transfer(_amount);
    }
    function transfer(address _to, uint256 _amount) public {
        require(isRegistered[msg.sender], "User not registered");
        require(isRegistered[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        totalTransfers += 1;
        totalTransactions += 1;
    }
    function getUserBalance(address _user) public view returns (uint256) {
        return balances[_user];
    }
    function getUserName(address _user) public view returns (string memory) {
        return users[_user].name;
    }
    function getTotalUsers() public view returns (uint256) {
        return totalUsers;
    }
    function getTotalBalance() public view returns (uint256) {
        return totalBalance;
    }
    function getTotalDeposits() public view returns (uint256) {
        return totalDeposits;
    }
    function getTotalWithdrawals() public view returns (uint256) {
        return totalWithdrawals;
    }
    function getTotalTransfers() public view returns (uint256) {
        return totalTransfers;
    }
    function getTotalTransactions() public view returns (uint256) {
        return totalTransactions;
    }
    function getUserAddresses() public view returns (address[] memory) {
        return userAddresses;
    

}
}
