import networkx as nx
import matplotlib.pyplot as plt

#Name of variables
input_nodes = ["G", "GS", "MP", "FG", "FGA", "X3P", "X3PA", "X2P", "X2PA", 
               "FT", "FTA", "ORB", "DRB", "AST", "STL", "BLK", "TOV", "PF", "PTS"]

#8 nodes
hidden_nodes = [f"H{i}" for i in range(1, 9)] 
output_nodes = ["ALL STAR"]  

G = nx.DiGraph()

# Add nodes
for node in input_nodes + hidden_nodes + output_nodes:
    G.add_node(node)

# Add lines
for i in input_nodes:
    for h in hidden_nodes:
        G.add_edge(i, h)

for h in hidden_nodes:
    for o in output_nodes:
        G.add_edge(h, o)

pos = {}

# Arrange layers
for i, node in enumerate(input_nodes):
    pos[node] = (-2, i - len(input_nodes) / 2)

for i, node in enumerate(hidden_nodes):
    pos[node] = (0, i - len(hidden_nodes) / 2)

pos["ALL STAR"] = (2, 0)

node_colors = []
for node in G.nodes:
    if node in input_nodes:
        node_colors.append("#4682B4")  # Blue for input
    elif node in hidden_nodes:
        node_colors.append("#32CD32")  # Green for hidden layer
    else:
        node_colors.append("#FFD700")  # Orange for output layer

# Plot
plt.figure(figsize=(8, 6))
nx.draw(G, pos, with_labels = True, node_color = node_colors, edge_color = 'gray', 
        node_size = 1200, font_size = 9, font_weight = "bold")

# Show plot
plt.title("Representation of the Neural Network")
plt.show()
