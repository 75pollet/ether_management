# EtherManagement

### Setup Instructions
Before running the project on your local environment;
   
  * Create an account on [Etherscan](https://etherscan.io/) and generate an API key from your account.
  * Create a `.env` file by running the command below and replace `<etherscan api key>` with the api key generated in the above step.
  
  ``cp .env.sample .env``
  

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Implementation Overview.

When a transaction hash is entered on [this form](http://localhost:4000/ethers/new), A request is sent to etherscan to fetch the transaction details which are then saved on the `transactions` table. The transaction should now be available on the [index page](http://localhost:4000/). The `complete` status of the transaction will be updated by the `scheduler` process which updates all available incomplete transactions which have 2 or more block confirmations after every 20 seconds. The updated transaction complete status can be seen by refreshing the index page.

