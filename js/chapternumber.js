function() {
    var sec= Document.querySelector("div.section.level2")
    var chap = parentNode.querySelector(sec);
    var chapnum = parseInt(chaplev.getAttribute('number'));
    sec.style.setProperty('--chapnum', chapnum);
}