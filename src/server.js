const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to capture client's IP address
app.set("trust proxy", true);

app.get("/", (req, res) => {
    res.json({
        timestamp: new Date().toISOString(),
        ip: req.ip
    });
});

app.listen(PORT, () => {
    console.log(`SimpleTimeService running on port ${PORT}`);
});
