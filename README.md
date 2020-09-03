# Diffie-Hellman-key-exchange
Implementation of the Diffie-Hellman key exchange in Ada.

# Usage
`./diffie-hellman Alice-private-key Bob-private-key Generator Prime-Number`

# Example

Input: 

`./diffie-hellman 342 183 621 929`

Output:
```
Generator: 621
Prime Number: 929
Alice's Private Key: 342
Bob's Private Key: 183
Alice sends the message 91 to Bob.
Bob sends the message 567 to Alice.
Alice gets the secret key 332
Bob gets the secret key 332
```
