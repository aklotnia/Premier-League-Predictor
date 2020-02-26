import React from 'react'
import Article from '../components/Article'

class NewsContainer extends React.Component {

    state = {
        page: 1
    }
    
    componentDidMount () {
        this.newsFetcher()
        this.refs.myscroll.addEventListener("scroll", () => {
        if (
            this.refs.myscroll.scrollTop + this.refs.myscroll.clientHeight >=
            this.refs.myscroll.scrollHeight
        ) {
            this.addNews()
        }
        });
    }

    addNews = () => {
        let newPage = this.state.page + 1
        fetch(`https://content.guardianapis.com/search?section=football&show-elements=all&page=${newPage}&api-key=`)
        .then(resp => resp.json())
        .then(parsed => this.setState({"articles": [...this.state.articles, ...parsed.response.results], "page": newPage}))
    }
    
    newsFetcher = () => {
        fetch(`https://content.guardianapis.com/search?section=football&show-elements=all&page=${this.state.page}&api-key=`)
        .then(resp => resp.json())
        .then(parsed => this.setState({"articles": parsed.response.results}))
    }

    newsRenderer = () => {
        if (this.state.articles) {
            return this.state.articles.map((article) => {
                return <Article article={article} />
            })
        }
    }

    render () {
        return(
            <div id="NewsContainerContainer">
                <h1>Recent News</h1>
                <div>Scroll Down For More</div>
                <div id="NewsContainer" ref="myscroll">
                    {this.newsRenderer()}
                </div>
            </div>
        )
    }
}

export default NewsContainer