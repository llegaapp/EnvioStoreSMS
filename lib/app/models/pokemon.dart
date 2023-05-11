class PokemonListModel {
  String? id;
  String? img;
  String? name;
  String? url;
  bool selected = false;
  PokemonModelDetail? detail;

  PokemonListModel({
    this.id,
    this.img,
    this.name,
    this.url,
    this.detail,
  });
  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      name: json['name'] == null ? '' : json['name'],
      url: json['url'] == null ? '' : json['url'],
    );
  }
  Map<String, dynamic> toJson(PokemonListModel item) {
    // List<Map<String, dynamic>>? _detail = item.detail != null
    //     ? item.detail!.map((i) => i.toJson(i)).toList()
    //     : null;

    return <String, dynamic>{
      'id': item.id,
      'img': item.img,
      'name': item.name,
      'url': item.url,
      'detail': item.detail,
    };
  }

  factory PokemonListModel.Copy(PokemonListModel o) {
    return PokemonListModel(
      id: o.id,
      img: o.img,
      name: o.name,
      url: o.url,
      detail: o.detail,
    );
  }

  String toString() {
    return 'Pokemon(  id: $id,\n name: $name,\n img: $img,\n url: $url,)\n detail: ' +
        detail.toString() +
        ',)\n )\n';
  }
}

class PokemonModelDetail {
  List<PokemonTypesList>? pokemonTypes;
  List<PokemonAbilities>? pokemonAbilities;

  PokemonModelDetail({
    this.pokemonTypes,
    this.pokemonAbilities,
  });

  factory PokemonModelDetail.fromJson(Map<String, dynamic> json) {
    var _pokemonTypes;
    if (json['types'] != null) {
      var items = json['types'];
      var t = items.map((f) => PokemonTypesList.fromJson(f)).toList();
      _pokemonTypes = t.cast<PokemonTypesList>().toList();
    }
    var _pokemonAbilities;
    if (json['abilities'] != null) {
      var items = json['abilities'];
      var t = items.map((f) => PokemonAbilities.fromJson(f)).toList();
      _pokemonAbilities = t.cast<PokemonAbilities>().toList();
    }
    return PokemonModelDetail(
      pokemonTypes: _pokemonTypes,
      pokemonAbilities: _pokemonAbilities,
    );
  }

  String toString() {
    return 'PokemonModelDetail(  pokemonTypes: $pokemonTypes \n pokemonAbilities: $pokemonAbilities  )\n';
  }
}

class PokemonTypesList {
  String? name;

  PokemonTypesList({
    this.name,
  });
  factory PokemonTypesList.fromJson(Map<String, dynamic> json) {
    String _name = '';
    if (json['type'] != null) {
      _name = json['type']['name'];
    }
    return PokemonTypesList(
      name: _name,
    );
  }

  String toString() {
    return 'PokemonTypesList(  name: $name  )\n';
  }
}

class PokemonAbilities {
  String? name;

  PokemonAbilities({
    this.name,
  });
  factory PokemonAbilities.fromJson(Map<String, dynamic> json) {
    String _name = '';
    if (json['ability'] != null) {
      _name = json['ability']['name'];
    }
    return PokemonAbilities(
      name: _name,
    );
  }

  String toString() {
    return 'PokemonAbilities(  name: $name  )\n';
  }
}
