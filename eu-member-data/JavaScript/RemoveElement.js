var elem=document.getElementsByClassName("{{class-name}}")
for(var x = 0; x < elem.length; x++) {
    elem.parent.removeChild(elem);
}
