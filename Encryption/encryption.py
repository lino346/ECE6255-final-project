from cryptography.fernet import Fernet

key = Fernet.generate_key()
print (key)

fernet = Fernet(key)
with open("key.key", 'wb') as filekey:
    filekey.write(key)

with open("key.key", 'rb') as filekey:
    filekey.read()

with open("../audio/SA1.WAV", 'rb') as f:
    original_audio = f.read()

encrypted_audio = fernet.encrypt(original_audio)
with open("SA1_encrypt.WAV", 'wb') as f:
    f.write(encrypted_audio)

decrypted_audio = fernet.decrypt(encrypted_audio)
with open("SA1_decrypt.WAV", 'wb') as f:
    f.write(decrypted_audio)
