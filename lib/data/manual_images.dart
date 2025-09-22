// Funcionalidad adicional #3:
// Mapeo manual título→asset para asegurar imágenes pertinentes por noticia.
// Se prioriza este mapeo y luego se cae al helper si no hay coincidencia.

const Map<String, String> manualImages = {
  // ===== Portada / generales =====
  'turbazos': 'assets/images/turbazo.jpg',
  'turbazo': 'assets/images/turbazo.jpg',

  'tornado en linares': 'assets/images/tornado-linares.jpg',
  'tornado linares': 'assets/images/tornado-linares.jpg',
  'tornado': 'assets/images/tornado-linares.jpg',
  'linares': 'assets/images/tornado-linares.jpg',
  'senapred': 'assets/images/tornado-linares.jpg',

  // ===== Deportes =====
  'alexis sánchez': 'assets/images/alexis.jpg',
  'alexis sanchez': 'assets/images/alexis.jpg',
  'gol de alexis': 'assets/images/alexis-2.jpg',
  'sevilla': 'assets/images/alexis-2.jpg',

  'champions league': 'assets/images/champions.jpg',
  'champions': 'assets/images/champions.jpg',

  'copa libertadores': 'assets/images/copa-libertadores.jpg',
  'libertadores': 'assets/images/copa-libertadores.jpg',
  'gol a gol': 'assets/images/copa-libertadores.jpg',

  'tabilo': 'assets/images/tabilo.jpg',
  'chengdú': 'assets/images/tabilo.jpg',
  'chengdu': 'assets/images/tabilo.jpg',

  'botsuana': 'assets/images/botsuana.jpg',
  'botswana': 'assets/images/botsuana.jpg',
  '4x400': 'assets/images/botsuana.jpg',

  // ===== Tendencias =====
  'carlos iii': 'assets/images/carlos.jpg',
  'rey carlos': 'assets/images/carlos.jpg',

  'windsor': 'assets/images/windsor.jpg',
  'banquete de estado': 'assets/images/windsor.jpg',

  'clósets compartidos': 'assets/images/closets.jpg',
  'closets compartidos': 'assets/images/closets.jpg',
  'closets': 'assets/images/closets.jpg',

  'chileno gana el máximo': 'assets/images/chileno.jpg',
  'martín pescador': 'assets/images/chileno.jpg',
  'fotografía de aves': 'assets/images/chileno.jpg',
  'chileno': 'assets/images/chileno.jpg',

  'estado indio': 'assets/images/india.jpg',
  'india': 'assets/images/india.jpg',
};
