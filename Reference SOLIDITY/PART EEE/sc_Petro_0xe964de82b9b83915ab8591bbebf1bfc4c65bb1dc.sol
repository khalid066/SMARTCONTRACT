/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
pragma solidity ^0.4.19;
 
contract SafeMath{
  function safeMul(uint a, uint b) internal returns (uint) {
    uint c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function safeDiv(uint a, uint b) internal returns (uint) {
    assert(b > 0);
    uint c = a / b;
    assert(a == b * c + a % b);
    return c;
  }
	
	function safeSub(uint a, uint b) internal returns (uint) {
    	assert(b <= a);
    	return a - b;
  }

	function safeAdd(uint a, uint b) internal returns (uint) {
    	uint c = a + b;
    	assert(c >= a);
    	return c;
  }
    function assert(bool assertion) internal {
    if (!assertion) assert;
  }
}


contract ERC20{

 	function totalSupply() constant returns (uint256 totalSupply) {}
	function balanceOf(address _owner) constant returns (uint256 balance) {}
	function transfer(address _recipient, uint256 _value) returns (bool success) {}
	function transferFrom(address _from, address _recipient, uint256 _value) returns (bool success) {}
	function approve(address _spender, uint256 _value) returns (bool success) {}
	function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}

	event Transfer(address indexed _from, address indexed _recipient, uint256 _value);
	event Approval(address indexed _owner, address indexed _spender, uint256 _value);


}

contract Petro is ERC20, SafeMath{
	
	mapping(address => uint256) balances;

	uint256 public totalSupply;


	function balanceOf(address _owner) constant public returns (uint256 balance) {
	    return balances[_owner];
	}

	function transfer(address _to, uint256 _value) public returns (bool success){
	    balances[msg.sender] = safeSub(balances[msg.sender], _value);
	    balances[_to] = safeAdd(balances[_to], _value);
	    Transfer(msg.sender, _to, _value);
	    return true;
	}

	mapping (address => mapping (address => uint256)) allowed;

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
	    var _allowance = allowed[_from][msg.sender];
	    
	    balances[_to] = safeAdd(balances[_to], _value);
	    balances[_from] = safeSub(balances[_from], _value);
	    allowed[_from][msg.sender] = safeSub(_allowance, _value);
	    Transfer(_from, _to, _value);
	    return true;
	}

	function approve(address _spender, uint256 _value) public returns (bool success) {
	    allowed[msg.sender][_spender] = _value;
	    Approval(msg.sender, _spender, _value);
	    return true;
	}

	function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
	    return allowed[_owner][_spender];

		}

	function () public payable {
		createTokens(msg.sender);
	}

	function createTokens(address recipient) public payable {
		if (msg.value == 0) {
		  assert;
		}

		uint tokens = safeDiv(safeMul(msg.value, price), 1 ether);
		totalSupply = safeAdd(totalSupply, tokens);

		balances[recipient] = safeAdd(balances[recipient], tokens);

		if (!owner.send(msg.value)) {
		  assert;
		}

	}
	string 	public name = "Petro";
	string 	public symbol = "PTR";
	uint 	public decimals = 8;
	uint 	public INITIAL_SUPPLY = 10000000000000000;
	uint256 public price;
	address public owner;

	function Petro() public {
	  totalSupply = INITIAL_SUPPLY;
	  balances[msg.sender] = INITIAL_SUPPLY;  // Give all of the initial tokens to the contract deployer.
		owner 	= msg.sender;
		price 	= 11;

	}
}