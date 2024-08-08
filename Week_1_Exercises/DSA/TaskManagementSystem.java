public class TaskManagementSystem {
    static class Task {
        private String taskId;
        private String taskName;
        private String status;
        public Task(String taskId, String taskName, String status) {
            this.taskId = taskId;
            this.taskName = taskName;
            this.status = status;
        }
        public String getTaskId() {
            return taskId;
        }
        public void setTaskId(String taskId) {
            this.taskId = taskId;
        }
        public String getTaskName() {
            return taskName;
        }
        public void setTaskName(String taskName) {
            this.taskName = taskName;
        }
        public String getStatus() {
            return status;
        }
        public void setStatus(String status) {
            this.status = status;
        }
        @Override
        public String toString() {
            return "TaskID: " + taskId + ", Name: " + taskName + ", Status: " + status;
        }
    }
    static class Node {
        private Task task;
        private Node next;
        public Node(Task task) {
            this.task = task;
            this.next = null;
        }
        public Task getTask() {
            return task;
        }
        public void setTask(Task task) {
            this.task = task;
        }
        public Node getNext() {
            return next;
        }
        public void setNext(Node next) {
            this.next = next;
        }
    }
    static class SinglyLinkedList {
        private Node head;
        public SinglyLinkedList() {
            this.head = null;
        }
        public void addTask(Task task) {
            Node newNode = new Node(task);
            if (head == null) {
                head = newNode;
            } else {
                Node current = head;
                while (current.getNext() != null) {
                    current = current.getNext();
                }
                current.setNext(newNode);
            }
        }
        public Task searchTask(String taskId) {
            Node current = head;
            while (current != null) {
                if (current.getTask().getTaskId().equals(taskId)) {
                    return current.getTask();
                }
                current = current.getNext();
            }
            return null;
        }
        public void traverseTasks() {
            Node current = head;
            if (current == null) {
                System.out.println("No tasks to display.");
                return;
            }
            while (current != null) {
                System.out.println(current.getTask());
                current = current.getNext();
            }
        }
        public void deleteTask(String taskId) {
            if (head == null) {
                System.out.println("No tasks to delete.");
                return;
            }
            if (head.getTask().getTaskId().equals(taskId)) {
                head = head.getNext();
                return;
            }
            Node current = head;
            while (current.getNext() != null && !current.getNext().getTask().getTaskId().equals(taskId)) {
                current = current.getNext();
            }

            if (current.getNext() != null) {
                current.setNext(current.getNext().getNext());
            } else {
                System.out.println("Task not found.");
            }
        }
    }
    public static void main(String[] args) {
        SinglyLinkedList taskManager = new SinglyLinkedList();
        taskManager.addTask(new Task("T001", "Design Homepage", "Pending"));
        taskManager.addTask(new Task("T002", "Develop API", "In Progress"));
        taskManager.addTask(new Task("T003", "Test Application", "Completed"));
        System.out.println("All Tasks:");
        taskManager.traverseTasks();
        System.out.println("\nSearching for task with ID T002:");
        Task searchResult = taskManager.searchTask("T002");
        System.out.println(searchResult != null ? searchResult : "Task not found");
        System.out.println("\nDeleting task with ID T003:");
        taskManager.deleteTask("T003");
        System.out.println("\nAll Tasks after deletion:");
        taskManager.traverseTasks();
    }
}
