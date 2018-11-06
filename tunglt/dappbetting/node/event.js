myContract.events.Transfer({  })
.on("data", function(event) {
  console.log(event)
}).on("error", console.error);