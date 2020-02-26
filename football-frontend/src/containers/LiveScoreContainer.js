import React from 'react'
import LiveGame from '../components/LiveGame'

class LiveScoreContainer extends React.Component {

    state = {

    }
    
    componentDidMount() {
        fetch('http://localhost:3000/live')
        .then(resp => resp.json())
        .then(parsed => this.setState({live: parsed.slice(40)}))
    }

    livegameRenderer = () => {
        if (this.state.live) {
            return this.state.live.map((livegame) => {
                return <LiveGame livegame={livegame} />
            })
        }
    }

    render() {
        return(
            <div id="LiveScoreContainer">
                {/* Liverpool: 1, Manchester City: 2 */}
                {this.livegameRenderer()}
            </div>
        )
    }
}

export default LiveScoreContainer