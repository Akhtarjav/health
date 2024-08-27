// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MentalHealthCheckup {
    address public owner;
    mapping(address => bool) public isDoctor;
    mapping(address => bool) public isPatient;
    mapping(address => uint256) public lastCheckupTimestamp;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyDoctor() {
        require(isDoctor[msg.sender], "Only registered doctors can call this function");
        _;
    }

    modifier onlyPatient() {
        require(isPatient[msg.sender], "Only registered patients can call this function");
        _;
    }

    // Register a doctor
    function registerDoctor() external {
        isDoctor[msg.sender] = true;
    }

    // Register a patient
    function registerPatient() external {
        isPatient[msg.sender] = true;
    }

    // Record a mental health checkup
    function recordCheckup() external onlyDoctor {
        lastCheckupTimestamp[msg.sender] = block.timestamp;
    }

    // Get the last checkup timestamp for a patient
    function getLastCheckupTimestamp(address patient) external view onlyDoctor returns (uint256) {
        return lastCheckupTimestamp[patient];
    }
}