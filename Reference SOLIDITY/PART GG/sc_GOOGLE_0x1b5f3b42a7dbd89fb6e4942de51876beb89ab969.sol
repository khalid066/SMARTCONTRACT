/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
pragma solidity ^0.4.16;


/**
 * V 0.4.21
 * GoogleToken extended ERC20 token contract created on the October 14th, 2017 by GoogleToken Development team in the US 
 *
 * For terms and conditions visit https://google.com
 */


interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public; }

contract GOOGLE {
    // Public variables of the token
    string public name = "Google Token";
    string public symbol = "GGL";
    uint8 public decimals = 18;											    // 18 decimals is the strongly suggested default
    uint256 public totalSupply;
    uint256 public googleSupply = 99999999986;
    uint256 public buyPrice = 100000000;
    address public creator;													// This creates an array with all balances
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    // This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint256 value);
    event FundTransfer(address backer, uint amount, bool isContribution);
    
    
    /**
     * Constrctor function
     *
     * Initializes contract with initial supply tokens to the creator of the contract
     */
    function GOOGLE() public {
        totalSupply = googleSupply * 10 ** uint256(decimals);  				// Update total supply with the decimal amount
        balanceOf[msg.sender] = totalSupply;    							// Give GoogleCoin Mint the total created tokens
        creator = msg.sender;
    }
    /**
     * Internal transfer, only can be called by this contract
     */
    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        // Check if the sender has enough
        require(balanceOf[_from] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        // Subtract from the sender
        balanceOf[_from] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);
      
    }

    /**
     * Transfer tokens
     *
     * Send `_value` tokens to `_to` from your account
     *
     * @param _to The address of the recipient
     * @param _value the amount to send
     */
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }
    
    /// @notice Buy tokens from contract by sending ether
    function () payable internal {
        uint amount = msg.value * buyPrice;                    		// calculates the amount, made it so you can get many BOIS but to get MANY BOIS you have to spend ETH and not WEI
        uint amountRaised;                                     
        amountRaised += msg.value;                            		// Many thanks bois, couldnt do it without r/me_irl
        require(balanceOf[creator] >= amount);               		// checks if it has enough to sell
        require(msg.value < 10**25);                        		// so any person who wants to put more then 0.1 ETH has time to think about what they are doing
        balanceOf[msg.sender] += amount;                  			// adds the amount to buyer's balance
        balanceOf[creator] -= amount;                        		// sends ETH to GoogleCoinMint
        Transfer(creator, msg.sender, amount);               		// execute an event reflecting the change
        creator.transfer(amountRaised);
    }

 }