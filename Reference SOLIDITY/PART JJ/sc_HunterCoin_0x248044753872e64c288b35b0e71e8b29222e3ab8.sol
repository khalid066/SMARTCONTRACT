/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
pragma solidity ^0.4.13;

contract HunterCoin {
    address public owner;
    string  public name;
    string  public symbol;
    uint8   public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* This notifies clients about the amount burnt */
    event Burn(address indexed from, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function HunterCoin() {
      balanceOf[msg.sender] = 210000;
      totalSupply = 210000;
      name = 'Hunter Coin';
      symbol = 'HTC';
      decimals = 100;
      owner = msg.sender;
    }

    function mintToken(address target, uint256 amount) returns (uint256 mintedAmount) {
      balanceOf[target] += amount;
      totalSupply += amount;
      Transfer(owner, target, amount);
      return amount;
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) returns (bool success) {
      require(balanceOf[msg.sender] > _value);

      balanceOf[msg.sender] -= _value;
      balanceOf[_to] += _value;
      Transfer(msg.sender, _to, _value);
      return true;
    }

    /* Allow another contract to spend some tokens in your behalf */
    function approve(address _spender, uint256 _value) returns (bool success) {
      allowance[msg.sender][_spender] = _value;
      return true;
    }

    /* A contract attempts to get the coins */
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
      require(balanceOf[_from] > _value);
      require(balanceOf[_to] + _value > balanceOf[_to]);
      require(_value < allowance[_from][msg.sender]);

      balanceOf[_from] -= _value;
      balanceOf[_to] += _value;
      allowance[_from][msg.sender] -= _value;
      Transfer(_from, _to, _value);
      return true;
    }

    function burn(uint256 _value) returns (bool success) {
      require(balanceOf[msg.sender] > _value);

      balanceOf[msg.sender] -= _value;
      totalSupply -= _value;
      Burn(msg.sender, _value);
      return true;
    }

    function burnFrom(address _from, uint256 _value) returns (bool success) {
      require(balanceOf[_from] > _value);
      require(_value < allowance[_from][msg.sender]);

      balanceOf[_from] -= _value;
      totalSupply -= _value;
      Burn(_from, _value);
      return true;
    }
}