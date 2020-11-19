// get idlist from https://trello.com/b/hmiXsuho/syncalyst.json

const initCard = () => {
  const myList = '5fb4e5f006c65105637a41a6';
  const taskCreation = document.querySelector("#new_task");
  const newTaskDesc = document.querySelector('#task_description').value;

  const creationSuccess = function (data) {
    console.log('Card created successfully.');
    console.log(JSON.stringify(data, null, 2));
  };

  const newCard = {
    name: 'New Test Card',
    desc: newTaskDesc,
    // Place this card at the top of our list
    idList: myList,
    pos: 'top'
  };

  taskCreation.addEventListener("submit", event => {
    window.Trello.post('/cards/', newCard, creationSuccess);
  });
}

export { initCard }
