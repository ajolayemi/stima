enum KmlFolderType {
  production(folderName: 'Stacchi Produttivi', isForProduction: true),
  access(folderName: 'Accessi', isForAccess: true);

  final String folderName;
  final bool isForAccess;
  final bool isForProduction;

  const KmlFolderType({
    required this.folderName,
    this.isForAccess = false,
    this.isForProduction = false,
  });
}
