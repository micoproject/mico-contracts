pragma solidity ^0.4.24;

//import "./inherited/HumanStandardToken.sol";
import "./IStandardBounties.sol";
import 'openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol';
import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';



/**
 * @title MicoManager
 * @dev Mico Manager
 */
contract MicoERC20 is DetailedERC20,MintableToken {
     constructor (string _name,string _symbol, uint8 _decimals) DetailedERC20(_name,_symbol,_decimals) public {
     }
}

contract MicoManager is Ownable {
	address public rewardToken;
  address public fundingToken;
  uint8 public currentPhase;
  mapping(bytes32=>bytes32[]) public taskFunder;
  mapping(bytes32=>bytes32) public taskState;

 enum TaskStages {
      Draft,
      Active,
      Dead
  }

	constructor (string _name,string _symbol, uint8 _decimals, address _fundingToken) public {
		rewardToken = new MicoERC20(_name,_symbol,_decimals);
    fundingToken = new ERC20(_fundingToken);
    currentPhase = 0;
  	}

    function createTask(bytes32 _taskID, string _taskData)public onlyOwner{
      assert(!taskStages[_taskID]);
      taskStages[_taskID] = taskStages.Draft;
    }

    // fund a certain task
    function fundTask(bytes32 _taskID, bytes32 _fundReference, uint256 _amountFunding, uint256 _amountReward){
      fundId = keccak256(msg.sender,_fundReference,_amountFunding,_amountReward);
      assert(!taskFunders[_taskID][fundId]);
      fundingToken.transferFrom(msg.sender,this,_amount);
      taskFunders[_taskID].push(fundId);
    }

    function activateTask(bytes32 _taskID, string _taskData)

    // cancel funding and withdraw funding
    function cancelFunding(bytes32 _taskID, bytes32 _fundReference, uint256 _amountFunding, uint256 _amountReward){
      fundId = keccak256(msg.sender,_fundReference,_amountFunding,_amountReward);
      assert(taskFunders[_taskID][fundId]);
      fundingToken.transfer(this,msg.sender,_amountFunding);
      delete taskFunders[_taskID][fundId];
    }

    function rewardTaskFunder(bytes32 _taskID,address _funder,bytes32 _taskID, bytes32 _fundReference, uint256 _amountFunding, uint256 _amountReward) public{
      fundId = keccak256(_funder,_fundReference,_amountFunding,_amountReward);
      assert(taskFunders[_taskID][fundId]);
      rewardToken.mint(_funder,_amountReward);
      delete taskFunders[_taskID][fundId];
    }

   //  function acceptFulfillment(uint _bountyId, uint _fulfillmentId) public onlyOwner {

   //  }

  	// function createIssue(string _IPFShash){
  	// 	//
  	// }

  	// function allocateBatch() public onlyOwner {
  	// 	//
  	// }

}
