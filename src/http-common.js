import axios from "axios";

export default axios.create({
  baseURL: "https://www.duacheteur.com/api",
  headers: {
    "Content-type": "application/json"
  }
});
