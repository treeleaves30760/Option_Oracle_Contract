// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

contract SeikaLink {
    address owner;
    address public oracleAddress;

    uint JobId = 0;

    struct optionPrice {
        uint JobId;
        string symbol;
        uint open;
        uint close;
        uint high;
        uint low;
        string openTime;
        string closeTime;
    }
    mapping (uint => optionPrice) results;
    mapping (uint => bool) resultsState;

    event EventGetOptionPrice(string coin, string date, uint256 price, string buytype, uint JobId);

    constructor () {
        owner = msg.sender;
    }

    // owner才能使用的
    modifier onlyOwner() {
        require(msg.sender == owner, 'Do are not owner');
        _;
    }

    // oracleAdress才能使用的
    modifier onlyOracleAddress() {
        require(msg.sender == oracleAddress, 'Do are not oracleAddress');
        _;
    }

    function setOwner(address newOwner) onlyOwner public {
        owner = newOwner;
    }

    function setOracleAddress(address newOracle) onlyOwner public {
        oracleAddress = newOracle;
    }


    function getOptionPrice(
        string calldata coin,      // What Coin's Option
        string calldata date,        // With format "YYMMDD", YY is the last two number of year in AD.
        uint256 price,      // The strike price
        string calldata buytype      // Buy Call for "C", Buy Put for "P"
    ) external returns (uint) {
        emit EventGetOptionPrice(
            coin,
            date,
            price,
            buytype,
            JobId
        );
        resultsState[JobId] = false;
        return JobId++;
    }

    function updateOptionPrice(
        uint JobIdReturn,
        uint open,
        uint close,
        uint high,
        uint low,
        string calldata openTime,
        string calldata closeTime,
        string calldata symbol
    ) external onlyOracleAddress {
        optionPrice memory res;
        res.JobId = JobIdReturn;
        res.open = open;
        res.close = close;
        res.high = high;
        res.low = low;
        res.symbol = symbol;
        res.openTime = openTime;
        res.closeTime = closeTime;
        results[JobIdReturn] = res;
        resultsState[JobIdReturn] = true;
    }

    function getResult(uint256 _JobId) external view returns (optionPrice memory) {
        require(resultsState[_JobId]);
        return results[_JobId];
    }
}