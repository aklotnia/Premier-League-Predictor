import React from 'react'
import Fixture from '../components/Fixture'

class UpcomingFixturesAllContainer extends React.Component {
    
    state = {

    }

    componentDidMount () {
        fetch('http://localhost:3000/games')
        .then(resp => resp.json())
        .then(parsed => this.setState({games: parsed}))
    }

    gameRenderer = () => {
        if (this.state.games) {
            return this.state.games.map((game) => {
                let keyid = Math.random()
                return <Fixture key={keyid} game={game} home={this.props.home} />
            })
        }
    }

    render () {
        return(
            <div id="UpcomingFixturesAllContainer">
                <table cellSpacing="0" cellPadding="4">
                    <thead>
                        <tr className="TableHeader">
                            <th>Date</th>
                            <th>Home Team</th>
                            <th></th>
                            <th>Away Team</th>
                        </tr>
                    </thead>
                    <tbody>
                        {this.gameRenderer()}
                    </tbody>
                </table>
            </div>
        )
    }
}

export default UpcomingFixturesAllContainer