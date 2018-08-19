pragma solidity ^0.4.24;

contract IStandardBounties {

  struct Bounty {
      address issuer;
      uint deadline;
      string data;
      uint fulfillmentAmount;
      address arbiter;
      bool paysTokens;
      BountyStages bountyStage;
      uint balance;
  }

  enum BountyStages {
      Draft,
      Active,
      Dead
  }

  function owner() public constant returns(address);
 // function bounties() public constant returns(Bounty);
  function issueBounty(
      address _issuer,
      uint _deadline,
      string _data,
      uint256 _fulfillmentAmount,
      address _arbiter,
      bool _paysTokens,
      address _tokenContract)
 public returns (uint);
  function issueAndActivateBounty(
      address _issuer,
      uint _deadline,
      string _data,
      uint256 _fulfillmentAmount,
      address _arbiter,
      bool _paysTokens,
      address _tokenContract,
      uint256 _value)
 public payable returns (uint);
  function contribute (uint _bountyId, uint _value) payable public;
  function activateBounty(uint _bountyId, uint _value) payable public;
  function fulfillBounty(uint _bountyId, string _data) public;
  function updateFulfillment(uint _bountyId, uint _fulfillmentId, string _data) public;
  function acceptFulfillment(uint _bountyId, uint _fulfillmentId) public;
  function killBounty(uint _bountyId) public;
  function extendDeadline(uint _bountyId, uint _newDeadline) public;
  function transferIssuer(uint _bountyId, address _newIssuer) public;
  function changeBountyDeadline(uint _bountyId, uint _newDeadline) public;
  function changeBountyData(uint _bountyId, string _newData) public;
  function changeBountyFulfillmentAmount(uint _bountyId, uint _newFulfillmentAmount) public;
  function changeBountyArbiter(uint _bountyId, address _newArbiter) public;
  function increasePayout(uint _bountyId, uint _newFulfillmentAmount, uint _value) public payable;
  function getFulfillment(uint _bountyId, uint _fulfillmentId) public constant returns (bool, address, string);
  function getBounty(uint _bountyId) public constant returns (address, uint, uint, bool, uint, uint);
  function getBountyArbiter(uint _bountyId) public constant returns (address);
  function getBountyData(uint _bountyId) public constant returns (string);
  function getBountyToken(uint _bountyId) public constant returns (address);
  function getNumBounties() public constant returns (uint);
  function getNumFulfillments(uint _bountyId) public constant returns (uint);
}
