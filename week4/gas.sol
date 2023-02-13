// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

// gas optimization HW
contract GasContract {
    uint256 public immutable totalSupply; // cannot be updated
    address[5] public administrators;

    struct Payment {
        PaymentType paymentType;
        uint256 amount;
    }

    event Transfer(address recipient, uint256 amount);
    mapping(address => uint256) balances;
    mapping(address => Payment[]) payments;
    mapping(address => uint256) public whitelist;

    constructor(address[5] memory _admins, uint256 _totalSupply) payable {
        administrators = _admins;
        totalSupply = _totalSupply;
    }

    function transfer(address _recipient, uint256 _amount, string calldata _name) external {
        payments[msg.sender].push(Payment(1, _amount));
        unchecked { 
            balances[_recipient] += _amount; 
            balances[msg.sender] -= _amount; // this line was missing from answer;
            }
        emit Transfer(_recipient, _amount);
    }

    function balanceOf(address _user) external view returns (uint256 balance_) {
        return balances[_user];
    }

    function getTradingMode() external pure returns (bool) {
        return true;
    }

    function getPayments(address _user) external view returns (Payment[] memory){
        return payments[_user];
    }

    function updatePayment(address _user, uint256 _ID, uint256 _amount, uint256 _type) external {
        payments[_user][0].paymentType = _type;
        payments[_user][0].amount = _amount;
    }

    function addToWhitelist(address _userAddrs, uint8 _tier) external {
        whitelist[_userAddrs] = _tier;
    }

    function whiteTransfer(address _recipient, uint256 _amount, Payment calldata _struct) external {
        unchecked {
        uint256 temp = _amount - whitelist[msg.sender];
        balances[msg.sender] -= temp;
        balances[_recipient] += temp;
        }
    }
}
