import { get } from "../utils/fetchHelper";

const UserRow = ({ user }) => {
  // const { fetch } = useFetch();

  const downloadCSV = async (id) => {
    await get(`/v1/users/${id}/export_order`);
  };

  return (
    <tr key={user.id}>
      <td>{user.username}</td>
      <td>{user.email}</td>
      <td>
        <button onClick={() => downloadCSV(user.id)}>Download</button>
      </td>
    </tr>
  );
};

export default UserRow;
