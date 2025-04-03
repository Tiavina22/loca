import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildHeader(), Expanded(child: _buildPostsList())],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePostDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Nouveau Laoka'),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mes Publications',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatCard('Publications', '12'),
              _buildStatCard('En attente', '2'),
              _buildStatCard('Vues', '1.2k'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 10, // Simuler des données
      itemBuilder: (context, index) {
        return _buildPostCard();
      },
    );
  }

  Widget _buildPostCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image du plat
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://th.bing.com/th/id/R.4eb92e7bcf68fab9f34696ebd7bb9b35?rik=osR8UIijAbHF2A&pid=ImgRaw&r=0&sres=1&sresct=1',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ravitoto sy Henakisoa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Disponible',
                        style: TextStyle(
                          color: AppColors.successColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Plat traditionnel malgache',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                // Prix et statistiques
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '15 000 Ar',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        _buildStatIcon(Icons.visibility, '245'),
                        const SizedBox(width: 16),
                        _buildStatIcon(Icons.favorite, '12'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          ButtonBar(
            children: [
              TextButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Modifier'),
                onPressed: () {},
              ),
              TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Supprimer'),
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(count, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder:
                (_, controller) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: CreatePostForm(scrollController: controller),
                ),
          ),
    );
  }
}

// Widget du formulaire de création séparé pour plus de clarté
class CreatePostForm extends StatefulWidget {
  final ScrollController scrollController;

  const CreatePostForm({super.key, required this.scrollController});

  @override
  State<CreatePostForm> createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        const Text(
          'Nouveau Laoka',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _buildImagePicker(),
        const SizedBox(height: 16),
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Nom du plat',
            border: OutlineInputBorder(),
          ),
          validator:
              (value) => value?.isEmpty ?? true ? 'Ce champ est requis' : null,
        ),
        const SizedBox(height: 16),
        _buildCategoryDropdown(),
        const SizedBox(height: 16),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Prix (Ar)',
            border: OutlineInputBorder(),
          ),
          validator:
              (value) => value?.isEmpty ?? true ? 'Ce champ est requis' : null,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Publier'),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        // TODO: Implémenter la sélection d'image
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
              SizedBox(height: 8),
              Text('Ajouter une photo'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    final categories = ['Soupes', 'Poissons', 'Viandes', 'Légumes'];
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Catégorie',
        border: OutlineInputBorder(),
      ),
      items:
          categories.map((category) {
            return DropdownMenuItem(value: category, child: Text(category));
          }).toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      validator:
          (value) =>
              value == null ? 'Veuillez sélectionner une catégorie' : null,
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implémenter la logique de publication
    }
  }
}
