// K čemu to je?
// Pokud nemůžete upravit nástroj se souhlasem, aby po změně souhlasu poslal samostatný event do dataLayeru, tak tento skript vám tento event vytvoří.
// Jak to funguje?
// Tak tímto skriptem upravíte funkci dataLayeru tak, že pokud sem pushe změna souhlasu, tak se automaticky odešle event consent_update_listener a stav souhlas jako normální dataLayeru push na který jde reagovat v GTM.
// Nasazení:
// Tento skript vloží do HTML značky v GTM (před něm dáte <script> a za něj </script>) a spustí se co nejdříve (consent init)

// Je to optimální řešešení? 
// Ne, ale je to řešení, když nemáte jinou možnost.

window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
(function() {
  var NativePush = window.dataLayer.push;
  window.dataLayer.push = function() {
    var states = [].slice.call(arguments, 0);
  	NativePush.apply(window.dataLayer, states);
    if (states[0][0]=="consent" && states[0][1]=="update" )
    {window.dataLayer.push({event:"consent_update_listener",consent_state:states[0][2]});}
  }
})();
