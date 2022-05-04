import React from "react";
import "./App.css";
import { useState } from "react";
import { ethers } from "ethers";
import Greeter from "./artifacts/contracts/Greeter.sol/Greeter.json";
import Token from "./artifacts/contracts/Token.sol/Token.json";

// Update with the contract address logged out to the CLI when it was deployed
const greeterAddress = "0x7974D496e85783183eF0f32AB7a2D7d7789d11c4";
const tokenAddress = "0xEB0c326efB4AC8028eED696d27cfBe6B56dCFC34";

function App() {
  // store greeting in local state
  const [greeting, setGreetingValue] = useState();
  const [amount, setAmount] = useState();
  const [userAccount, setUserAccount] = useState();

  // request access to the user's MetaMask account
  async function requestAccount() {
    await window.ethereum.request({ method: "eth_requestAccounts" });
  }

  // call the smart contract, read the current greeting value
  async function fetchGreeting() {
    if (typeof window.ethereum !== "undefined") {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(
        greeterAddress,
        Greeter.abi,
        provider
      );
      try {
        const data = await contract.greet();
        console.log("data: ", data);
      } catch (err) {
        console.log("Error: ", err);
      }
    }
  }

  const getBalance = async () => {
    if (typeof window.ethereum != "undefined") {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      console.log({ account });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(tokenAddress, Token.abi, signer);
      try {
        const balance = await contract.balanceOf(account);

        console.log({ balance: balance.toString() });

        // setUserAccount(balance.toString());
      } catch (err) {
        console.log(err);
      }
    }
  };

  const sendCoins = async () => {
    if (typeof window.ethereum !== "undefined") {
      try {
        await requestAccount();
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(tokenAddress, Token.abi, signer);
        console.log({ userAccount, amount: Number(amount) });
        const transaction = await contract.transfer(
          userAccount,
          Number(amount)
        );
        await transaction.wait();
        console.log(`${amount} Coins successfully sent to ${userAccount}`);
      } catch (err) {
        console.log(err);
      }
    }
  };

  // call the smart contract, send an update
  async function setGreeting() {
    if (!greeting) return;
    if (typeof window.ethereum !== "undefined") {
      await requestAccount();
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      console.log({ provider });
      const signer = provider.getSigner();
      console.log({ signer });
      const contract = new ethers.Contract(greeterAddress, Greeter.abi, signer);
      console.log({ contract });
      const transaction = await contract.setGreeting(greeting);
      console.log({ transaction });
      await transaction.wait();
      fetchGreeting();
    }
  }

  return (
    <div className="App">
      <header className="App-header">
        <button onClick={fetchGreeting}>Fetch Greeting</button>
        <button onClick={setGreeting}>Set Greeting</button>
        <input
          onChange={(e) => setGreetingValue(e.target.value)}
          placeholder="Set greeting"
        />

        <br />
        <button onClick={getBalance}>Get Balance</button>
        <button onClick={sendCoins}>Send Coins</button>
        <input
          onChange={(e) => setUserAccount(e.target.value)}
          placeholder="Account ID"
        />
        <input
          onChange={(e) => setAmount(e.target.value)}
          placeholder="Amount"
        />
      </header>
    </div>
  );
}

export default App;
