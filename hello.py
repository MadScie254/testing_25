print("Hello, World!")
def greet(name):
    """Function to greet a person with their name."""
    return f"Hello, {name}!" 
if __name__ == "__main__":
    print(greet("Alice"))
    print(greet("Bob"))
    print(greet("Charlie"))
# This script prints a greeting message and defines a function to greet a person by name.
# It includes a main block to demonstrate the function with different names.
# The script is designed to be run directly, and it will print greetings for Alice, Bob, and Charlie.

import asyncio
import aiohttp
import time

async def fetch_url(session, url):
    """Fetches a single URL and returns the response text."""
    async with session.get(url) as response:
        return await response.text()

async def main():
    """Main function to fetch multiple URLs concurrently."""
    urls = [
        "https://api.github.com",
        "https://api.github.com/users/MadScie254",
        "https://api.github.com/users/octocat",
        "https://httpbin.org/get",
    ]

    async with aiohttp.ClientSession() as session:
        tasks = [fetch_url(session, url) for url in urls]
        start_time = time.time()
        results = await asyncio.gather(*tasks)
        end_time = time.time()

        for url, result in zip(urls, results):
            print(f"URL: {url}")
            print(f"First 100 characters: {result[:100]}\n")

        print(f"Total time taken: {end_time - start_time:.2f} seconds")

if __name__ == "__main__":
    # To run this in a Jupyter environment, you might need to handle the event loop differently
    # For a standard Python script, asyncio.run() is sufficient.
    # If you see a "RuntimeError: asyncio.run() cannot be called from a running event loop",
    # you can use the following instead:
    # loop = asyncio.get_event_loop()
    # if loop.is_running():
    #     task = loop.create_task(main())
    # else:
    #     asyncio.run(main())
    asyncio.run(main())