import { API_URL } from "../constants";

const get = async (url) => {
  const response = await fetch(`${API_URL}${url}`);
  if (!response.ok) {
    throw response;
  }

  const data = await response.json();

  return data;
};

export { get };
