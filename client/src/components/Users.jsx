import { useEffect, useState } from "react";
import { get } from "../utils/fetchHelper";
import UserRow from "./UserRow";

const Users = () => {
  // const { data } = useFetch("/v1/users");
  const [data, setData] = useState([]);

  useEffect(() => {
    async function loadUsers() {
      try {
        const response = await get("/v1/users");
        setData(response);
      } catch (error) {
        console.log(error);
      }
    }

    loadUsers();
  }, []);
  return (
    <div>
      <table>
        <thead>
          <tr>
            <th>Username</th>
            <th>Email</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {data.map((user) => (
            <UserRow user={user} key={user.id} />
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Users;
