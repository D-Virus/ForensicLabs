from selenium import webdriver

# using Chrome WebDriver
driver = webdriver.Chrome()

websites = [
    "https://twitter.com",
    "https://www.instagram.com",
    "https://www.linkedin.com",
    "https://www.openai.com",
    "https://www.tiktok.com",
    "https://www.netflix.com",
    "https://www.google.com",
    "https://www.facebook.com",
    "https://web.whatsapp.com",
    "https://www.amazon.com",
    "https://www.reddit.com",
    "https://discord.com",
    "https://www.nytimes.com",
    "https://espndeportes.espn.com",
    "https://www.marca.com"
]

for website in websites:
    driver.get(website)
    # add delay if necessary
    # time.sleep(10)

driver.quit()


