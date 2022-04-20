# EtherManagement

### Setup Instructions
Before running the project on your local environment;
   
  * Create an account on [Etherscan](https://etherscan.io/) and generate an API key from your account.
  * Create a `.env` file in the root directory of the project and add the line below replacing `<etherscan api key>` with the api key generated in the above step.
  
  ```
  export  EtherScan_API_KEY=<etherscan api key>
  ```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

