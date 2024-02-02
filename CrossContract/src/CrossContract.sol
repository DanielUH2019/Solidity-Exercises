// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {
        // your code here
        (bool ok, bytes memory data) = _priceOracle1.call(abi.encodeWithSignature("price()")); 
        require(ok, "failed to call price() on PriceOracle1");
        uint256 price1 = abi.decode(data, (uint256));

        (ok, data) = _priceOracle2.call(abi.encodeWithSignature("price()"));
        require(ok, "failed to call price() on PriceOracle2");
        uint256 price2 = abi.decode(data, (uint256));

        return price1 < price2 ? price1 : price2;
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
