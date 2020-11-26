const initTaskForm = () => {

  const avatars = document.querySelectorAll('.task-avatar');

  if (avatars) {
    avatars.forEach((avatar)=>{
      avatar.addEventListener("click", event =>{
      const task_forms = document.querySelectorAll('.task-form');
      task_forms.forEach((form) => {
        if (form.dataset.userid === avatar.dataset.userid) {
          const avatarForm = form;
          if (avatarForm.style.display === "none") {
            avatarForm.style.display = "block";
          } else {
            avatarForm.style.display = "none";
          }
        }
        });
      console.log('task form toggling');
      });
    });
  }
};

export { initTaskForm };
