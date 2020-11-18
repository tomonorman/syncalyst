const initCard = () => {
  const myList = 'INSERT YOUR IDLIST HERE';
  const taskCreation = document.querySelector("#new_task");

  const creationSuccess = function (data) {
    console.log('Card created successfully.');
    console.log(JSON.stringify(data, null, 2));
  };

  const newCard = {
    name: 'New Test Card',
    desc: 'This is the description of our new card.',
    // Place this card at the top of our list
    idList: myList,
    pos: 'top'
  };

  window.Trello.post('/cards/', newCard, creationSuccess);
}

export { initCard }
