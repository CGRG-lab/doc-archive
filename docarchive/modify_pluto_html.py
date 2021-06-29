import argparse

def setup_parser() -> argparse.ArgumentParser:
    """Set up Python's ArgumentParser with path of HTML.

    Returns
    -------
    argparse.ArgumentParser
        Initialized parser.
    """
    parser = argparse.ArgumentParser(add_help=True)

    parser.add_argument("src", help="path of original pluto HTML file.")
    parser.add_argument("--dest", help="path of modified pluto HTML file. Default is the same as `src`.", default=None)

    return parser


def main():

    parser = setup_parser()
    args = parser.parse_args()
    src_html = args.src
    dest_html = args.src if args.dest is None else args.dest
    
    insert_str = """<!-- Modify layout: Start !!! -->
<style type="text/css" >
    /* align left: center -> flex-start */
    body {
        align-items: flex-start;
    }
</style>

<style type="text/css" >
    /* min-width: 1081 -> 1000 */
    @media screen and (min-width: 1000px) {
        .plutoui-toc.aside {
            position:fixed; 
            right: 1rem;
            top: 5rem; 
            width:25%; 
            padding: 10px;
            border: 3px solid rgba(0, 0, 0, 0.15);
            border-radius: 10px;
            box-shadow: 0 0 11px 0px #00000010;
            /* That is, viewport minus top minus Live Docs */
            max-height: calc(100vh - 5rem - 56px);
            overflow: auto;
            z-index: 50;
            background: white;
        }
    }
</style>
<!-- Modify layout: End !!! -->

</html>"""

    with open(src_html, "r", encoding="utf-8") as f:
        html_str = f.read()

    with open(dest_html, "w", encoding="utf-8") as f:
        f.write(html_str.replace("</html>", insert_str))

if __name__ == "__main__":
    main()