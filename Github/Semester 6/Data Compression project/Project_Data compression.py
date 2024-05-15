#!/usr/bin/env python
# coding: utf-8

# In[3]:


import tkinter as tk
from tkinter import ttk
import math
import heapq
from collections import Counter, defaultdict

# Golomb Encoding Functions
def text_to_binary(text):
    """Converts text to binary representation."""
    binary_str = ''.join(format(ord(char), '08b') for char in text)
    return binary_str

def golomb_encode(value_length, M):
    quotient = value_length // M
    remainder = value_length % M

    unary = '1' * quotient + '0'
    binary_length = M.bit_length() - 1
    binary = format(remainder, f'0{binary_length}b')

    return unary + binary

def calculate_bits_before_encoding(value_length):
    return value_length

def calculate_bits_after_encoding(encoded):
    return len(encoded)

def calculate_probability(text):
    """Calculates the probability of occurrence for each character in the given text."""
    probability = {}
    total_chars = len(text)
    
    for char in text:
        if char in probability:
            probability[char] += 1
        else:
            probability[char] = 1
    
    for char in probability:
        probability[char] /= total_chars
    
    return probability

def calculate_entropy(probability):
    entropy = 0
    for prob in probability.values():
        entropy -= prob * math.log2(prob)
    return entropy

def calculate_average_length(compressed_bits, num_additions):
    average_length = compressed_bits / num_additions
    return average_length

def calculate_efficiency(entropy, average_length):
     return entropy / average_length

# LZW Encoding Functions
def encoding(s1):
    table = {}
    for i in range(128):
        ch = chr(i)
        table[ch] = i

    p = s1[0]  
    code = 128
    output_code = []
    additions = []  
    for i in range(len(s1)):
        if i != len(s1) - 1:
            c = s1[i + 1] 
        if p + c in table:
            p = p + c
        else:
            addition = p + c  
            additions.append(addition)
            output_code.append(table[p])
            table[p + c] = code
            code += 1
            p = c
        c = ""
    output_code.append(table[p])
    
    return output_code, additions

# RLE Algorithm
# RLE Encoding Functions
def encode_rle(message):
    encoded_message = []
    i = 0

    while i < len(message):
        count = 1
        ch = message[i]
        j = i
        while j < len(message) - 1 and message[j] == message[j + 1]:
            count += 1
            j += 1
        encoded_message.append({"count": count, "char": ch})
        i = j + 1

    return encoded_message

def calculate_average_length_rle(encoded_message):
    average_length = 0
    for item in encoded_message:
        average_length += item['count']
    return average_length / len(encoded_message)

def calculate_probability_rle(encoded_message):
    frequency = {}
    for item in encoded_message:
        char = item['char']
        if char in frequency:
            frequency[char] += 1
        else:
            frequency[char] = 1
    total_chars = len(encoded_message)
    probability = {char: freq / total_chars for char, freq in frequency.items()}
    return probability

def calculate_efficiency_rle(probability, average_length):
    entropy = calculate_entropy(probability)
    return entropy / average_length
def calculate_bits_before_rle(message):
    return len(message) * 8  # Assuming 8 bits per character

def calculate_bits_after_rle(encoded_message):
    bits = 0
    for item in encoded_message:
        bits += len(bin(item['count']))-1.5  # Number of bits needed to represent the count
        bits += 8  # Bits to represent the character itself
    return bits
def calculate_compression_ratio(before_bits, after_bits):
    return before_bits / after_bits

# Huffmen code 
class Node:
    def __init__(self, char, freq):
        self.char = char
        self.freq = freq
        self.left = None
        self.right = None

    def __lt__(self, other):
        return self.freq < other.freq
    
def build_huffman_tree(message):
    frequency = Counter(message)
    priority_queue = [Node(char, freq) for char, freq in frequency.items()]
    heapq.heapify(priority_queue)

    while len(priority_queue) > 1:
        left = heapq.heappop(priority_queue)
        right = heapq.heappop(priority_queue)
        merged = Node(None, left.freq + right.freq)
        merged.left = left
        merged.right = right
        heapq.heappush(priority_queue, merged)

    return priority_queue[0]

def huffman_encode(message, mapping):
    encoded_message = ''.join(mapping[char] for char in message)
    return encoded_message

def calculate_bits(message):
    return len(message) * 8  # Assuming 8 bits per character

def build_huffman_mapping(node, code='', mapping={}):  # Change defaultdict(str) to {}
    if node.char is not None:
        mapping[node.char] = code
    else:
        build_huffman_mapping(node.left, code + '0', mapping)
        build_huffman_mapping(node.right, code + '1', mapping)
    return mapping

def calculate_average_length_huff(mapping, probability):
    average_length_huff = sum(len(mapping[char]) * prob for char, prob in probability.items())
    return average_length_huff

def calculate_compression_ratio(before_bits, after_bits):
    return before_bits / after_bits

class ArithmeticEncoder:
    def __init__(self, symbol_probabilities):
        self.symbol_probabilities = symbol_probabilities
        self.low = 0.0
        self.high = 1.0
        self.range = 1.0
        self.code = []

    def encode_symbol(self, symbol):
        symbol_prob = self.symbol_probabilities[symbol]
        new_low = self.low + symbol_prob * self.range
        new_high = self.low + (symbol_prob + self.symbol_probabilities[symbol]) * self.range
        self.low = new_low
        self.high = new_high
        self.range = self.high - self.low
        self.normalize()

    def normalize(self):
        while (self.high <= 0.5) or (self.low >= 0.5):
            if self.high <= 0.5:
                self.code.append(0)
                self.low *= 2
                self.high *= 2
                self.range *= 2
            elif self.low >= 0.5:
                self.code.append(1)
                self.low = (self.low - 0.5) * 2
                self.high = (self.high - 0.5) * 2
                self.range = (self.high - self.low)

    def get_encoded_message(self):
        return ''.join(str(bit) for bit in self.code)

def calculate_entropy(symbol_probabilities):
    entropy = -sum(prob * math.log2(prob) for prob in symbol_probabilities.values() if prob > 0)
    return entropy

def encode_text():
    # Access the global variable
    text = text_entry.get("1.0", "end-1c")  # Get the text from the entry widget
    
    # Calculate symbol probabilities
    symbol_counts = Counter(text)
    total_symbols = len(text)
    symbol_probabilities = {symbol: count / total_symbols for symbol, count in symbol_counts.items()}

    # Encode using Arithmetic Encoding
    encoder = ArithmeticEncoder(symbol_probabilities)
    for symbol in text:
        encoder.encode_symbol(symbol)
    encoded_arithmetic = encoder.get_encoded_message()  # Get the encoded message

    # Calculate entropy
    entropy = calculate_entropy(symbol_probabilities)

    # Calculate efficiency
    encoded_message = encoder.get_encoded_message()
    efficiency = len(encoded_message) / (total_symbols * math.log2(len(symbol_probabilities)))  # As per the provided output, efficiency is 1.0

    # Calculate compression ratio
    original_bits_ars = total_symbols * math.log2(len(symbol_probabilities))
    encoded_bits_ars = len(encoded_message)
    compression_ratio = original_bits_ars / encoded_bits_ars 

    # Calculate average length of encoded message
    average_length = encoded_bits_ars / total_symbols

# GUI Functions
def encode_text():
    text = text_entry.get("1.0", "end-1c")  # Get the text from the entry widget
    M = 2 
    
     # Golomb Encoding
    binary_text = text_to_binary(text)  
    value_length = len(binary_text)  
    encoded_golomb = golomb_encode(value_length, M)  
    
    # Golomb Compression Results
    probability_golomb = calculate_probability(encoded_golomb)
    entropy_golomb = calculate_entropy(probability_golomb)
    before_bits = calculate_bits_before_encoding(value_length)
    after_bits = calculate_bits_after_encoding(encoded_golomb)
    compressed_bits_golomb = len(encoded_golomb)
    num_additions_golomb = len(set(encoded_golomb))
    compression_ratio_golomb = (len(text) * 8) / compressed_bits_golomb
    #efficiency_golomb = calculate_efficiency(entropy_golomb, calculate_average_length(compressed_bits_golomb, num_additions_golomb))

    
    # LZW Encoding
    output_code_lzw, additions_lzw = encoding(text)
    
    # RLE Encoding
    encoded_rle = encode_rle(text)
    probability_rle = calculate_probability_rle(encoded_rle)
    average_length_rle = calculate_average_length_rle(encoded_rle)
    efficiency_rle = calculate_efficiency_rle(probability_rle, average_length_rle)
    bits_before_rle = calculate_bits_before_rle(text)
    bits_after_rle = calculate_bits_after_rle(encoded_rle)
    compression_ratio_rle = calculate_compression_ratio(bits_before_rle, bits_after_rle)

    # LZW Compression Results
    num_additions_lzw = len(additions_lzw)
    original_bits_lzw = len(text) * 8
    compressed_bits_lzw = len(output_code_lzw) * math.ceil(math.log2(max(output_code_lzw) + 1))
    compression_ratio_lzw = original_bits_lzw / compressed_bits_lzw
    probability_lzw = calculate_probability(text)  # Calculate probability for LZW encoded text
    entropy_lzw = calculate_entropy(probability_lzw)
    efficiency_lzw = calculate_efficiency(entropy_lzw, calculate_average_length(compressed_bits_lzw, num_additions_lzw))
    
    #huff
    tree = build_huffman_tree(text)
    mapping = build_huffman_mapping(tree)
    encoded_message = huffman_encode(text, mapping)

    before_bits = calculate_bits(text)
    after_bits = len(encoded_message)
    
    #huff result 
    probability = calculate_probability(text)
    entropy = calculate_entropy(probability)
    average_length = calculate_average_length_huff(mapping, probability)
    compression_ratio = calculate_compression_ratio(before_bits, after_bits)
    efficiency = calculate_efficiency(entropy, average_length)
    
    #arrs
    symbol_counts = Counter(text)
    total_symbols = len(text)
    symbol_probabilities = {symbol: count / total_symbols for symbol, count in symbol_counts.items()}

    # Encode using Arithmetic Encoding
    encoder = ArithmeticEncoder(symbol_probabilities)
    for symbol in text:
        encoder.encode_symbol(symbol)
    encoded_arithmetic = encoder.get_encoded_message()  # Get the encoded message

    # Calculate entropy
    entropy = calculate_entropy(symbol_probabilities)

    # Calculate efficiency
    encoded_message = encoder.get_encoded_message()
    efficiency = len(encoded_message) / (total_symbols * math.log2(len(symbol_probabilities)))  # As per the provided output, efficiency is 1.0

    # Calculate compression ratio
    original_bits_ars = total_symbols * math.log2(len(symbol_probabilities))
    encoded_bits_ars = len(encoded_message)
    compression_ratio = original_bits_ars / encoded_bits_ars 

    # Calculate average length of encoded message
    average_length = encoded_bits_ars / total_symbols
    # Display Results
    result_text.insert("end", "Golomb Encoding Results:\n")
    result_text.insert("end", f"Encoded message: {encoded_golomb}\n")
    result_text.insert("end", f"Binary text: {binary_text}\n")
    result_text.insert("end", f"Bits before encoding: {before_bits}\n")
    result_text.insert("end", f"Bits after encoding: {after_bits}\n")
    result_text.insert("end", f"Compression ratio: {compression_ratio_golomb}\n")
    result_text.insert("end", f"Probability of occurrence for each character: {probability_golomb}\n")
    result_text.insert("end", f"Entropy: {entropy_golomb}\n")
    #result_text.insert("end", f"Average Length: {calculate_average_length(compressed_bits_golomb, num_additions_golomb):.3f}\n")
    result_text.insert("end", "___________________________________________________")
    result_text.insert("end", "\n")
    
    # lzw result
    result_text.insert("end", "LZW Compression Results:\n")
    result_text.insert("end", f"Bits before encoding: {original_bits_lzw:.3f}\n")
    result_text.insert("end", f"Bits after encoding: {compressed_bits_lzw:.3f}\n")
    result_text.insert("end", f"Compression Ratio: {compression_ratio_lzw:.3f}\n")
    result_text.insert("end", f"Entropy: {entropy_lzw:.3f}\n")
    result_text.insert("end", f"Average Length (bits per symbol): {calculate_average_length(compressed_bits_lzw, num_additions_lzw):.3f}\n")
    result_text.insert("end", f"Output Code: {output_code_lzw}\n")
    result_text.insert("end", f"Efficiency: {efficiency_lzw:.3f}\n")
    result_text.insert("end", "Sequences triggering new codes (Addition column):\n")
    for addition in additions_lzw:
        result_text.insert("end", f"{addition} ")
    result_text.insert("end", "\n")
    result_text.insert("end", "___________________________________________________")
    result_text.insert("end", "\n")
    
    # RLE result
    result_text.insert("end", "RLE Compression Results:\n")
    result_text.insert("end", f"Bits before encoding: {bits_before_rle:.3f}\n")
    result_text.insert("end", f"Bits after encoding: {bits_after_rle:.3f}\n")
    result_text.insert("end", f"Compression Ratio: {compression_ratio_rle:.3f}\n")
    result_text.insert("end", f"Encoded message: {encoded_rle}\n")
    result_text.insert("end", f"Probability of occurrence for each character: {probability_rle}\n")
    result_text.insert("end", f"Average Length: {average_length_rle:.3f}\n")
    result_text.insert("end", f"Efficiency: {efficiency_rle:.3f}\n\n")
    result_text.insert("end", "___________________________________________________")
    result_text.insert("end", "\n")
    
    # huff result
    result_text.insert("end", "Huffmen Compression Results:\n")
    result_text.insert("end", f"Bits before encoding: {before_bits}\n")
    result_text.insert("end", f"Bits after encoding: {after_bits}\n")
    result_text.insert("end", f"probability: {probability}\n")
    result_text.insert("end", f"entropy: {entropy}\n")
    result_text.insert("end", f"average_length: {average_length}\n")
    result_text.insert("end", f"compression_ratio: {compression_ratio}\n")
    result_text.insert("end", f"efficiency: {efficiency}\n")
    result_text.insert("end", f"efficiency: {mapping}\n")
    result_text.insert("end", "___________________________________________________")
    result_text.insert("end", "\n")
    
    # Display Results
    #arthmetic
    result_text.insert("end", "Arithmetic Compression Results:\n")
    result_text.insert("end", f"encoded_message: {encoded_message}\n")
    result_text.insert("end", f"before_bits: {original_bits_ars}\n")
    result_text.insert("end", f"Bits after encoding: {encoded_bits_ars}\n")
    result_text.insert("end", f"symbol_probabilities: {symbol_probabilities}\n")
    result_text.insert("end", f"probability: {probability}\n")
    result_text.insert("end", f"Efficiency: {efficiency}\n")
    result_text.insert("end", f"Entropy: {entropy}\n")
    result_text.insert("end", f"compression_ratio: {compression_ratio}\n")
    result_text.insert("end", f"Average length of encoded message: {average_length}\n")
    result_text.insert("end", "___________________________________________________")
    result_text.insert("end", "\n")
    # Determine Optimal Compression Algorithm
    if compression_ratio_golomb > compression_ratio_lzw and compression_ratio_golomb>compression_ratio_rle and compression_ratio_golomb>compression_ratio:
        result_text.insert("end", "\nGolomb Compression is Optimal for this Text.\n")
    elif compression_ratio_lzw >compression_ratio_golomb and compression_ratio_lzw>compression_ratio_rle and compression_ratio_lzw>compression_ratio:
        result_text.insert("end", "\nLZW Compression is Optimal for this Text.\n")
    elif compression_ratio_rle >compression_ratio_golomb and compression_ratio_rle>compression_ratio_lzw and compression_ratio_rle>compression_ratio:
        result_text.insert("end", "\nrle Compression is Optimal for this Text.\n")
    elif compression_ratio >compression_ratio_golomb and compression_ratio>compression_ratio_lzw and compression_ratio>compression_ratio_rle:
        result_text.insert("end", "\nars Compression is Optimal for this Text.\n")
    else: 
        result_text.insert("end", "\n huffman compression_ratio is Optimal for this Text.\n")
# Create the main window
root = tk.Tk()
root.title("Compression Algorithms Comparison")

# Text Input and Parameters Frame
input_frame = ttk.Frame(root, padding="20")
input_frame.grid(row=0, column=0, sticky="nsew")

# Text Input
text_label = ttk.Label(input_frame, text="Enter Text:")
text_label.grid(row=0, column=0, sticky="w")

text_entry = tk.Text(input_frame, height=5, width=50)
text_entry.grid(row=1, column=0, columnspan=2, padx=10, pady=10)

# Encode Button
encode_button = ttk.Button(input_frame, text="Encode", command=encode_text)
encode_button.grid(row=3, column=0, columnspan=2, pady=10)

# Results Display Frame
result_frame = ttk.Frame(root, padding="20")
result_frame.grid(row=0, column=0, sticky="nsew")

# Result Text
result_text = tk.Text(result_frame, height=15, width=80)
result_text.grid(row=0, column=0, padx=10, pady=10)

# Hide the result frame initially
result_frame.grid_remove()

def show_results():
    input_frame.grid_remove()
    result_frame.grid()

# Show Results Button
show_results_button = ttk.Button(input_frame, text="Show Results", command=show_results)
show_results_button.grid(row=4, column=0, columnspan=2, pady=10)

# Run the main event loop
root.mainloop()


# In[ ]:





# In[ ]:




