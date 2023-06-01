import hashlib
import time

def simulate_cryptominer():
    data = "I am a block of data".encode()
    max_nonce = 10**6  # A million iterations.

    # Repeat the hash computation many times.
    for nonce in range(max_nonce):
        # Compute a hash of the data with the nonce appended.
        hash_object = hashlib.sha256(data + str(nonce).encode())
        hex_dig = hash_object.hexdigest()
        print(hex_dig)

        # Pause for a bit to simulate the time it takes to mine.
        time.sleep(0.01)

simulate_cryptominer()
