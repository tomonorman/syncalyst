// get idlist from https://trello.com/b/hmiXsuho/syncalyst.json

const initTrelloCard = () => {
  const myList = '5fc0568a36aa4d0b6dda9613';
  const taskForm = document.querySelectorAll('.new_task');

  const creationSuccess = function (data) {
    console.log('Card created successfully.');
    console.log(JSON.stringify(data, null, 2));
  };

if (taskForm) {
  taskForm.forEach((form) => {
     form.addEventListener("submit", event => {
      const newTaskDesc = form.querySelector('.task_description input');
      const userInput = form.querySelector('.task_user_id input');
      const user = userInput.dataset.trelloid;
      // gets the trello user id
      const task = userInput.dataset.meeting;
      // gets the meeting title

      const newCard = {
        name: newTaskDesc.value,
        desc: `(This is a task automatically assigned from a Syncalyst meeting)
        Meeting: ${task}`,
        idMembers: [user],
        idList: myList,
        // Place this card at the top/bottom of our list
        pos: 'top'
      };
      window.Trello.post('/cards/', newCard, creationSuccess);
    });
  });
  }
};

export { initTrelloCard }

// popup window to add a new card
// const url = 'https://trello.com/add-card?url=http://localhost:3000/meetings/34&name=new&idList=5fb4e5f006c65105637a41a6';

// window.Trello.addCard({
//   url: url
// });
