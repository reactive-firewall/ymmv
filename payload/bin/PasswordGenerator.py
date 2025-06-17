#! /usr/bin/env python

# Disclaimer of Warranties.
# A. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY
#    APPLICABLE LAW, USE OF THIS PYTHON SCRIPT AND ANY SERVICES PERFORMED
#    BY OR ACCESSED THROUGH THIS PYTHON SCRIPT IS AT YOUR SOLE RISK AND
#    THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND
#    EFFORT IS WITH YOU.
#
# B. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS PYTHON SCRIPT
#    AND SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE", WITH ALL FAULTS AND
#    WITHOUT WARRANTY OF ANY KIND, AND THE AUTHOR OF THIS PYTHON SCRIPT'S LICENSORS
#    (COLLECTIVELY REFERRED TO AS "THE AUTHOR" FOR THE PURPOSES OF THIS DISCLAIMER)
#    HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THIS PYTHON SCRIPT
#    SOFTWARE AND SERVICES, EITHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
#    NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF
#    MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE,
#    ACCURACY, QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS.
#
# C. THE AUTHOR DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE
#    THE AUTHOR's SOFTWARE AND SERVICES, THAT THE FUNCTIONS CONTAINED IN, OR
#    SERVICES PERFORMED OR PROVIDED BY, THIS PYTHON SCRIPT WILL MEET YOUR
#    REQUIREMENTS, THAT THE OPERATION OF THIS PYTHON SCRIPT OR SERVICES WILL
#    BE UNINTERRUPTED OR ERROR-FREE, THAT ANY SERVICES WILL CONTINUE TO BE MADE
#    AVAILABLE, THAT THIS PYTHON SCRIPT OR SERVICES WILL BE COMPATIBLE OR
#    WORK WITH ANY THIRD PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES,
#    OR THAT DEFECTS IN THIS PYTHON SCRIPT OR SERVICES WILL BE CORRECTED.
#    INSTALLATION OF THIS THE AUTHOR SOFTWARE MAY AFFECT THE USABILITY OF THIRD
#    PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES.
#
# D. YOU FURTHER ACKNOWLEDGE THAT THIS PYTHON SCRIPT AND SERVICES ARE NOT
#    INTENDED OR SUITABLE FOR USE IN SITUATIONS OR ENVIRONMENTS WHERE THE FAILURE
#    OR TIME DELAYS OF, OR ERRORS OR INACCURACIES IN, THE CONTENT, DATA OR
#    INFORMATION PROVIDED BY THIS PYTHON SCRIPT OR SERVICES COULD LEAD TO
#    DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE,
#    INCLUDING WITHOUT LIMITATION THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
#    NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, LIFE SUPPORT OR
#    WEAPONS SYSTEMS.
#
# E. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY THE AUTHOR
#    SHALL CREATE A WARRANTY. SHOULD THIS PYTHON SCRIPT OR SERVICES PROVE DEFECTIVE,
#    YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
#    Limitation of Liability.
# F. TO THE EXTENT NOT PROHIBITED BY APPLICABLE LAW, IN NO EVENT SHALL THE AUTHOR
#    BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT OR
#    CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES
#    FOR LOSS OF PROFITS, CORRUPTION OR LOSS OF DATA, FAILURE TO TRANSMIT OR
#    RECEIVE ANY DATA OR INFORMATION, BUSINESS INTERRUPTION OR ANY OTHER
#    COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR
#    INABILITY TO USE THIS PYTHON SCRIPT OR SERVICES OR ANY THIRD PARTY
#    SOFTWARE OR APPLICATIONS IN CONJUNCTION WITH THIS PYTHON SCRIPT OR
#    SERVICES, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT,
#    TORT OR OTHERWISE) AND EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE
#    POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION
#    OR LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR
#    CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event
#    shall THE AUTHOR's total liability to you for all damages (other than as may
#    be required by applicable law in cases involving personal injury) exceed
#    the amount of five dollars ($5.00). The foregoing limitations will apply
#    even if the above stated remedy fails of its essential purpose.
#
################################################################################

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

