const initTaskForm = () => {

  const avatars = document.querySelectorAll('.mtgtableattendee');

  if (avatars) {
    avatars.forEach((avatar)=>{
      avatar.addEventListener("click", event =>{
      console.log('clicking works');
      const task_forms = document.querySelectorAll('.task-form');
      task_forms.forEach((form) => {
        if (form.dataset.userid === avatar.dataset.userid) {
          const avatarForm = form;
          console.log(avatarForm);
          if (avatarForm.style.display === "none") {
            avatarForm.style.display = "block";
          } else {
            avatarForm.style.display = "none";
          }
        }
        });

      });
    });
  }
};


export { initTaskForm };
