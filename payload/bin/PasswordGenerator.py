import secrets
import string
import os

class PasswordGenerator:
	def __init__(self, length=32, weak_passwords_file=None):
		self.length = length
		self.weak_passwords = self.load_weak_passwords(weak_passwords_file)
		self.adjacency_map = self.create_adjacency_map()

	def load_weak_passwords(self, filepath):
		"""Load weak passwords from a file."""
		weak_passwords = set()
		if filepath and os.path.isfile(filepath):
			with open(filepath, 'r') as file:
				for line in file:
					weak_passwords.add(line.strip())
		return weak_passwords

	def create_adjacency_map(self):
		"""Create a mapping of keys to their adjacent keys on a QWERTY keyboard."""
		return {
			'q': 'wa', 'w': 'qesad', 'e': 'wrd3s', 'r': 'etdf', 't': 'ryfg',
			'y': 'tuhg', 'u': 'yij7', 'i': 'ujok', 'o': 'iklp9', 'p': 'ol',
			'a': 'qwsz', 's': 'awdezx', 'd': 'serfcx', 'f': 'dtrgv', 'g': 'fthyvb',
			'h': 'gyujbn', 'j': 'huikm', 'k': 'jil0', 'l': 'ok',
			'z': 'as', 'x': 'zsdc', 'c': 'xdfv', 'v': 'cfgb', 'b': 'vghn',
			'n': 'bhj', 'm': 'nj'
		}

	def is_strong_password(self, password):
		"""Check if the password is strong (not in weak passwords list)."""
		return password not in self.weak_passwords

	def generate_password(self):
		"""Generate a strong password with dynamic complexity."""
		password_chars = []
		available_chars = string.ascii_letters + string.digits + string.punctuation

		for _ in range(self.length):
			if password_chars:
				# Exclude adjacent characters based on the last chosen character
				last_char = password_chars[-1].lower()
				adjacent_chars = self.adjacency_map.get(last_char, '')
				available_chars = ''.join(c for c in available_chars if c.lower() not in adjacent_chars)

			# Choose a character from the available set
			next_char = secrets.choice(available_chars)
			password_chars.append(next_char)

		password = ''.join(password_chars)

		# Ensure the password is strong
		if self.is_strong_password(password):
			return password
		else:
			return self.generate_password()  # Regenerate if the password is weak

# Example usage
if __name__ == "__main__":
	generator = PasswordGenerator(length=32, weak_passwords_file='weak_passwords.txt')
print(generator.generate_password())

