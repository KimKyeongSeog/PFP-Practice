// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MintNFT is ERC721Enumerable {

    string metadataURI;
    uint maxSupply;

    constructor(string memory _name, string memory _symbol, string memory _metadataURI, uint _maxSupply) ERC721(_name, _symbol) {
        metadataURI = _metadataURI;
        maxSupply = _maxSupply;
    }
// 배포 시 수정불가, 다시 올려야함..
    function mintNFT() public{
        require(totalSupply() < maxSupply, "No more mint." );

        uint tokenId = totalSupply() + 1;

        _mint(msg.sender, tokenId);
    }
//if문과 require의 차이 , 가스비 차이 함수실행 전 비교, 함수 실행 후 비교
//reveal
//payable
    function batchMint(uint _amount) public {
        for(uint i = 0; i < _amount; i++) {
            mintNFT();
        }
    }
//    
    function tokenURI(uint _tokenId) public override view returns(string memory) {

        return string(abi.encodePacked(metadataURI, '/', Strings.toString(_tokenId), '.json'));
// 숫자, 슬래시, string을 더해주어야 하나, 솔리디티 문법상 각 구성을 string으로 바꾸어 더하기 위해 string(abi.encodePacked...(바이트값 형변환) string.toString (스트링으로 형변환)
}
//메타데이터를 확인하는 코드, 
// override 
//외부에서 메타데이터를 불러오기 때문에 별도로 코드로 관리할 필요 없음
// abi.encodePacked() 는 JS에서 더하기 함수를 쓰는 것에 반해 솔리디티에서는 불가능 하기에 별도의 함수를 사용
// Strings.toString(_tokenId) => Uint를 String으로 전환하기 위해 사용되었으며 , String.sol을 import한 뒤 사용
}