import { useContext, useEffect, useState } from "react";
import { API_URL } from "../constants";
import { CableContext } from "../context/cable";

const Users = () => {
  const [users, setUsers] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadUsers() {
      try {
        const response = await fetch(`${API_URL}/v1/users`);
        if (response.ok) {
          const json = await response.json();
          setUsers(json);
        } else {
          throw response;
        }
      } catch (e) {
        setError("An error ocurred");
      } finally {
        setLoading(false);
      }
    }

    loadUsers();
  }, []);

  const downloadCSV = async (id) => {
    const response = await fetch(`${API_URL}/v1/users/${id}/export_order`);
  };

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
          {users.map((user) => (
            <tr key={user.id}>
              <td>{user.username}</td>
              <td>{user.email}</td>
              <td>
                <button onClick={() => downloadCSV(user.id)}>Download</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Users;
