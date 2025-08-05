// Wait for the DOM to fully load
document.addEventListener("DOMContentLoaded", () => {
    // Configure AWS SDK with your credentials
    AWS.config.update({
        accessKeyId: "AKIA4HTA2NOBTBFT36WN",
        secretAccessKey: "ZgJ8UAkkODlC46Nf+Dp4EAbQymPi8WebqKoLwM7V",
        region: "eu-west-1"
    });

    // Create an S3 instance
    const s3 = new AWS.S3();

    // Function to fetch and display images
    async function listAndDisplayImages() {
        const bucketName = "persualia";
        const folderPath = "web/logos-clients/"; // Folder path inside the bucket

        const params = {
            Bucket: bucketName,
            Prefix: folderPath,
        };

        try {
            // List objects in the bucket
            const data = await s3.listObjectsV2(params).promise();
            const images = data.Contents.map(item => {
                return `https://${bucketName}.s3.${AWS.config.region}.amazonaws.com/${item.Key}`;
            });

            // Display the image URLs
            console.log("Image URLs:", images);

            // Get the target section
            const logosSection = document.getElementById("logos-section");
            if (!logosSection) {
                console.error('Element with ID "logos-section" not found');
                return;
            }
    
            // Dynamically display images inside the target section
            images.forEach(url => {
                if (!url.endsWith('/')) {
                    const img = document.createElement("img");
                    img.src = url;
                    logosSection.appendChild(img);
                }
            });
        } catch (error) {
            console.error("Error fetching images:", error);
        }
    }

    // Run the function
    listAndDisplayImages();
});
