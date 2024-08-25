const HEADERS = [
  "USERNAME",
  "USER_EMAIL",
  "PRODUCT_CODE",
  "PRODUCT_NAME",
  "PRODUCT_CATEGORY",
  "ORDER_DATE",
];

const toCSV = (jsonData) => {
  if (jsonData.length === 0) {
    throw new Error("No data");
  }

  // create headers
  const headers = [...[HEADERS.join(",") + "\n"]];

  const rows = jsonData.map((d) => Object.values(d).join(",")).join("\n");

  return headers + rows;
};

function downloadCSV(jsonData) {
  const csvData = toCSV(jsonData);

  // Check if CSV data is empty
  if (csvData === "") {
    alert("No data to export");
  } else {
    // Create CSV file and initiate download
    const blob = new Blob([csvData], { type: "text/csv;charset=utf-8;" });
    const link = document.createElement("a");
    link.href = URL.createObjectURL(blob);
    link.setAttribute("download", "product_data.csv");
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }
}

export default downloadCSV;
