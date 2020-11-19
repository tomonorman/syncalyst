// get idlist from https://trello.com/b/hmiXsuho/syncalyst.json

const initTrelloCard = () => {
  const myList = '5fb4e5f006c65105637a41a6';
  const taskForm = document.getElementById('new_task');
  const newTaskDesc = document.getElementById('task_description');
  // const taskMemeber =

  const creationSuccess = function (data) {
    console.log('Card created successfully.');
    console.log(JSON.stringify(data, null, 2));
  };

  taskForm.addEventListener("submit", event => {
    const newCard = {
      name: newTaskDesc.value,
      // desc: 'new desc',
      //idMembers: [taskMember],
      idList: myList,
      // Place this card at the top of our list
      pos: 'top'
    };
    // event.preventDefault();
    window.Trello.post('/cards/', newCard, creationSuccess);
    console.log('working');
  });

  // popup window to add a new card
  // const url = 'https://trello.com/add-card?url=http://localhost:3000/meetings/34&name=new&idList=5fb4e5f006c65105637a41a6';

  // window.Trello.addCard({
  //   url: url
  // });
};

export { initTrelloCard }
